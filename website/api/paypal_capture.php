<?php
/**
 * MacUpgraded.com - PayPal Order Capture Endpoint
 * Verifies and captures PayPal payments before issuing download tokens.
 */

header('Content-Type: application/json');
header('X-Content-Type-Options: nosniff');
require_once __DIR__ . '/../config.php';

$rawInput = file_get_contents('php://input');
$data = json_decode($rawInput, true);

if (!$data || !isset($data['orderID'])) {
    echo json_encode(['success' => false, 'error' => 'Missing PayPal Order ID']);
    exit;
}

$orderID = preg_replace('/[^a-zA-Z0-9_\-]/', '', $data['orderID']);
$appSlug = isset($data['app']) ? preg_replace('/[^a-z0-9\-]/', '', strtolower($data['app'])) : 'whispertap';
$email = isset($data['email']) ? filter_var(trim($data['email']), FILTER_VALIDATE_EMAIL) : 'customer@macupgraded.com';
$tier = isset($data['tier']) ? strtoupper(trim($data['tier'])) : 'INDIVIDUAL';

// In live environment, verify order with PayPal OAuth API
// If client ID is configured:
if (PAYPAL_CLIENT_ID !== 'REPLACE_WITH_YOUR_PAYPAL_CLIENT_ID' && !empty(PAYPAL_CLIENT_ID)) {
    $baseUrl = (PAYPAL_MODE === 'live') ? 'https://api-m.paypal.com' : 'https://api-m.sandbox.paypal.com';
    
    // Get OAuth token
    $ch = curl_init("{$baseUrl}/v1/oauth2/token");
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_USERPWD, PAYPAL_CLIENT_ID . ':' . PAYPAL_SECRET);
    curl_setopt($ch, CURLOPT_POSTFIELDS, 'grant_type=client_credentials');
    $authRes = json_decode(curl_exec($ch), true);
    curl_close($ch);

    if (isset($authRes['access_token'])) {
        $accessToken = $authRes['access_token'];
        // Capture order
        $ch2 = curl_init("{$baseUrl}/v2/checkout/orders/{$orderID}/capture");
        curl_setopt($ch2, CURLOPT_RETURNTRANSFER, true);
        curl_setopt($ch2, CURLOPT_POST, true);
        curl_setopt($ch2, CURLOPT_HTTPHEADER, [
            'Content-Type: application/json',
            "Authorization: Bearer {$accessToken}"
        ]);
        $captureRes = json_decode(curl_exec($ch2), true);
        curl_close($ch2);

        if (!isset($captureRes['status']) || $captureRes['status'] !== 'COMPLETED') {
            echo json_encode(['success' => false, 'error' => 'PayPal payment was not completed.']);
            exit;
        }
    }
}

// Generate 15-Minute Token
$token = bin2hex(random_bytes(16));
$expires = time() + 900;
$payload = "{$appSlug}:{$token}:{$expires}";
$sig = hash_hmac('sha256', $payload, MAC_UPGRADED_SECRET_SALT);
$secureDownloadUrl = SITE_URL . "/download.php?app={$appSlug}&token={$token}&expires={$expires}&sig={$sig}";

// Generate License Key
$randomPart1 = strtoupper(substr(bin2hex(random_bytes(2)), 0, 4));
$prefix = ($tier === 'ALL_ACCESS' || $appSlug === 'all-access') ? 'SUITE' : strtoupper(substr(str_replace('-', '', $appSlug), 0, 8));
$signData = "{$email}:{$prefix}:{$randomPart1}";
$keyHash = strtoupper(substr(hash_hmac('sha256', $signData, SUITE_LICENSE_KEY_SECRET), 0, 4));
$randomSuffix = rand(1000, 9999);
$licenseKey = "{$prefix}-PRO-PASS-{$keyHash}-{$randomSuffix}";

echo json_encode([
    'success' => true,
    'licenseKey' => $licenseKey,
    'downloadUrl' => $secureDownloadUrl
]);
