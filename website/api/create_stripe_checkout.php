<?php
/**
 * MacUpgraded.com - Create Real Stripe Checkout Session (Single & Multi-App Cart)
 * Supports Apple Pay, Google Pay, and all Credit/Debit cards.
 */

header('Content-Type: application/json');
header('X-Content-Type-Options: nosniff');
require_once __DIR__ . '/../config.php';

// Receive Request Payload
$rawInput = file_get_contents('php://input');
$data = json_decode($rawInput, true);

if (!$data) {
    echo json_encode(['success' => false, 'error' => 'Invalid JSON request payload']);
    exit;
}

$email = isset($data['email']) ? filter_var(trim($data['email']), FILTER_VALIDATE_EMAIL) : null;
if (!$email) {
    echo json_encode(['success' => false, 'error' => 'Please provide a valid email address for your software license delivery.']);
    exit;
}

// Check if multi-app cart or single item
$items = isset($data['items']) && is_array($data['items']) ? $data['items'] : [];

if (empty($items)) {
    $appSlug = isset($data['app']) ? preg_replace('/[^a-z0-9\-]/', '', strtolower(trim($data['app']))) : 'whispertap';
    $appName = isset($data['name']) ? htmlspecialchars(trim($data['name'])) : 'MacUpgraded Utility';
    $priceNum = isset($data['price']) ? intval($data['price']) : 9;
    
    if ($appSlug === 'all-access') {
        $priceNum = 129;
        $appName = 'All-Access 130-App Lifetime Pass (Promo)';
    }

    $items[] = [
        'slug' => $appSlug,
        'name' => $appName,
        'price' => $priceNum
    ];
}

// Verify if Stripe API Key is configured
if (STRIPE_SECRET_KEY === 'sk_live_REPLACE_WITH_YOUR_STRIPE_SECRET_KEY' || empty(STRIPE_SECRET_KEY)) {
    echo json_encode([
        'success' => false,
        'requires_config' => true,
        'error' => 'Stripe Secret Key not configured yet. Please enter your Stripe API key in website/config.php on Hostinger to accept live payments!'
    ]);
    exit;
}

// Build post fields for Stripe API
$postFields = [
    'payment_method_types[]' => 'card',
    'mode' => 'payment',
    'customer_email' => $email,
    'success_url' => SITE_URL . '/success.php?session_id={CHECKOUT_SESSION_ID}',
    'cancel_url' => SITE_URL . '/#apps',
];

$slugList = [];
foreach ($items as $idx => $item) {
    $slug = preg_replace('/[^a-z0-9\-]/', '', strtolower(trim($item['slug'])));
    $name = htmlspecialchars(trim($item['name']));
    $price = intval($item['price']) * 100;
    
    $slugList[] = $slug;
    
    $postFields["line_items[{$idx}][price_data][currency]"] = 'usd';
    $postFields["line_items[{$idx}][price_data][product_data][name]"] = $name . ' (Lifetime License)';
    $postFields["line_items[{$idx}][price_data][product_data][description]"] = 'Lifetime Personal & Commercial license on up to 5 Macs.';
    $postFields["line_items[{$idx}][price_data][unit_amount]"] = $price;
    $postFields["line_items[{$idx}][quantity]"] = 1;
}

$postFields['metadata[app_slugs]'] = implode(',', $slugList);
$postFields['metadata[customer_email]'] = $email;

$ch = curl_init('https://api.stripe.com/v1/checkout/sessions');
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_USERPWD, STRIPE_SECRET_KEY . ':');
curl_setopt($ch, CURLOPT_POST, true);
curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($postFields));
curl_setopt($ch, CURLOPT_HTTPHEADER, ['Content-Type: application/x-www-form-urlencoded']);

$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

$session = json_decode($response, true);

if ($httpCode === 200 && isset($session['url'])) {
    echo json_encode([
        'success' => true,
        'checkoutUrl' => $session['url'],
        'sessionId' => $session['id']
    ]);
} else {
    $errorMsg = isset($session['error']['message']) ? $session['error']['message'] : 'Failed to create Stripe Checkout session';
    echo json_encode([
        'success' => false,
        'error' => $errorMsg
    ]);
}
