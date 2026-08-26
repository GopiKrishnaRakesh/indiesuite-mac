<?php
/**
 * MacUpgraded.com - Create Real Stripe Checkout Session
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
$appSlug = isset($data['app']) ? preg_replace('/[^a-z0-9\-]/', '', strtolower(trim($data['app']))) : 'whispertap';
$tier = isset($data['tier']) ? strtoupper(trim($data['tier'])) : 'INDIVIDUAL';
$appName = isset($data['name']) ? htmlspecialchars(trim($data['name'])) : 'MacUpgraded Utility';
$priceNum = isset($data['price']) ? intval($data['price']) : 9;

if (!$email) {
    echo json_encode(['success' => false, 'error' => 'Please provide a valid email address for your software license.']);
    exit;
}

// If All-Access Pass, enforce $129 promo price
if ($appSlug === 'all-access' || $tier === 'ALL_ACCESS') {
    $priceNum = 129;
    $appName = 'All-Access 130-App Lifetime Pass (Promo)';
}

$priceInCents = $priceNum * 100;

// Verify if Stripe API Key is configured
if (STRIPE_SECRET_KEY === 'sk_live_REPLACE_WITH_YOUR_STRIPE_SECRET_KEY' || empty(STRIPE_SECRET_KEY)) {
    echo json_encode([
        'success' => false,
        'requires_config' => true,
        'error' => 'Stripe Secret Key not configured yet. Please enter your Stripe API key in website/config.php to accept live payments!'
    ]);
    exit;
}

// Build Stripe Checkout Session Payload via cURL
$postFields = [
    'payment_method_types[]' => 'card',
    'mode' => 'payment',
    'customer_email' => $email,
    'success_url' => SITE_URL . '/success.php?session_id={CHECKOUT_SESSION_ID}&app=' . urlencode($appSlug),
    'cancel_url' => SITE_URL . '/#apps',
    'line_items[0][price_data][currency]' => 'usd',
    'line_items[0][price_data][product_data][name]' => $appName . ' - Lifetime License',
    'line_items[0][price_data][product_data][description]' => 'Lifetime Personal & Commercial license for ' . $appName . ' on up to 5 Macs.',
    'line_items[0][price_data][unit_amount]' => $priceInCents,
    'line_items[0][quantity]' => 1,
    'metadata[app_slug]' => $appSlug,
    'metadata[tier]' => $tier,
    'metadata[customer_email]' => $email,
];

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
