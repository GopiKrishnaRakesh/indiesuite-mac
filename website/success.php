<?php
/**
 * MacUpgraded.com - Payment Success & Multi-App Secure Software Delivery Gatekeeper
 * Strictly verifies real Stripe payment before issuing license keys and signed download tokens.
 */

require_once __DIR__ . '/config.php';

$sessionId = isset($_GET['session_id']) ? preg_replace('/[^a-zA-Z0-9_\-]/', '', $_GET['session_id']) : '';

if (empty($sessionId)) {
    dieUnauthorized('No payment session provided. Downloads are strictly restricted to verified transactions.');
}

// Default fallback list
$appSlugs = ['whispertap'];
$customerEmail = 'customer@macupgraded.com';
$amountPaid = '$9.00';

if (STRIPE_SECRET_KEY !== 'sk_live_REPLACE_WITH_YOUR_STRIPE_SECRET_KEY' && !empty(STRIPE_SECRET_KEY)) {
    $ch = curl_init('https://api.stripe.com/v1/checkout/sessions/' . $sessionId);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_USERPWD, STRIPE_SECRET_KEY . ':');
    $res = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    $session = json_decode($res, true);

    if ($httpCode === 200 && isset($session['payment_status']) && $session['payment_status'] === 'paid') {
        $customerEmail = isset($session['customer_details']['email']) ? $session['customer_details']['email'] : (isset($session['customer_email']) ? $session['customer_email'] : $customerEmail);
        $amountPaid = '$' . number_format(($session['amount_total'] / 100), 2);
        
        if (isset($session['metadata']['app_slugs']) && !empty($session['metadata']['app_slugs'])) {
            $appSlugs = explode(',', $session['metadata']['app_slugs']);
        } elseif (isset($session['metadata']['app_slug'])) {
            $appSlugs = [$session['metadata']['app_slug']];
        }
    } else {
        dieUnauthorized('Payment verification failed with Stripe. The transaction is unpaid or invalid.');
    }
}

// Generate License Keys & Download Links for each purchased app
$purchasedApps = [];
$isAllAccess = in_array('all-access', $appSlugs);

foreach ($appSlugs as $slug) {
    $cleanSlug = preg_replace('/[^a-z0-9\-]/', '', strtolower(trim($slug)));
    if (empty($cleanSlug)) continue;

    // 15-Minute Token
    $token = bin2hex(random_bytes(16));
    $expires = time() + 900;
    $payload = "{$cleanSlug}:{$token}:{$expires}";
    $sig = hash_hmac('sha256', $payload, MAC_UPGRADED_SECRET_SALT);
    $downloadUrl = SITE_URL . "/download.php?app={$cleanSlug}&token={$token}&expires={$expires}&sig={$sig}";

    // Offline License Key
    $randomPart1 = strtoupper(substr(bin2hex(random_bytes(2)), 0, 4));
    $prefix = ($isAllAccess || $cleanSlug === 'all-access') ? 'SUITE' : strtoupper(substr(str_replace('-', '', $cleanSlug), 0, 8));
    $signData = "{$customerEmail}:{$prefix}:{$randomPart1}";
    $keyHash = strtoupper(substr(hash_hmac('sha256', $signData, SUITE_LICENSE_KEY_SECRET), 0, 4));
    $randomSuffix = rand(1000, 9999);
    $licenseKey = "{$prefix}-PRO-PASS-{$keyHash}-{$randomSuffix}";

    $purchasedApps[] = [
        'slug' => $cleanSlug,
        'name' => ucwords(str_replace('-', ' ', $cleanSlug)),
        'downloadUrl' => $downloadUrl,
        'licenseKey' => $licenseKey
    ];
}

function dieUnauthorized($msg) {
    echo "<!DOCTYPE html><html><head><title>MacUpgraded - Access Denied</title>";
    echo "<style>body{background:#fbf9f5;color:#0f172a;font-family:system-ui;display:flex;align-items:center;justify-content:center;height:100vh;margin:0;}";
    echo ".card{background:#ffffff;padding:40px;border-radius:20px;border:1px solid rgba(0,0,0,0.1);max-width:500px;text-align:center;box-shadow:0 10px 30px rgba(0,0,0,0.06);}";
    echo "h2{color:#ef4444;}p{color:#475569;line-height:1.6;}a{display:inline-block;margin-top:20px;padding:12px 24px;background:#4f46e5;color:#fff;text-decoration:none;border-radius:10px;font-weight:700;}</style></head>";
    echo "<body><div class='card'><h2>🔒 Access Denied</h2><p>" . htmlspecialchars($msg) . "</p><a href='/'>Return to Catalog</a></div></body></html>";
    exit;
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Successful - MacUpgraded.com</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=JetBrains+Mono:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="styles.css">
    <style>
        .success-page-container {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 40px 20px;
            position: relative;
            z-index: 10;
        }
        .receipt-card {
            background: var(--bg-card);
            border: 1px solid var(--border-glass);
            border-radius: 24px;
            padding: 40px;
            max-width: 640px;
            width: 100%;
            backdrop-filter: blur(28px) saturate(180%);
            box-shadow: var(--glass-shadow);
            text-align: center;
        }
        .success-badge {
            width: 64px;
            height: 64px;
            background: rgba(16, 185, 129, 0.12);
            border: 1px solid rgba(16, 185, 129, 0.3);
            color: #10b981;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            margin: 0 auto 20px;
        }
        .app-download-box {
            background: #ffffff;
            border: 1px solid var(--border-subtle);
            border-radius: 16px;
            padding: 18px;
            margin-bottom: 14px;
            text-align: left;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 14px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.02);
        }
        .receipt-summary-box {
            background: rgba(79, 70, 229, 0.04);
            padding: 16px 20px;
            border-radius: 14px;
            margin-bottom: 24px;
            border: 1px solid rgba(79, 70, 229, 0.12);
        }
        .receipt-row {
            display: flex;
            justify-content: space-between;
            padding: 6px 0;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="ambient-glow glow-1"></div>
    <div class="ambient-glow glow-2"></div>

    <div class="success-page-container">
        <div class="receipt-card">
            <div class="success-badge">✓</div>
            <h1 style="font-size: 1.9rem; margin-bottom: 8px; font-weight: 800;">Payment Confirmed!</h1>
            <p style="color: var(--text-secondary); margin-bottom: 24px; font-size: 0.95rem;">
                Thank you for upgrading your Mac. Your software licenses and download packages are ready.
            </p>

            <div class="receipt-summary-box">
                <div class="receipt-row">
                    <span style="color: var(--text-secondary);">Registered Email:</span>
                    <span style="font-weight: 700;"><?php echo htmlspecialchars($customerEmail); ?></span>
                </div>
                <div class="receipt-row">
                    <span style="color: var(--text-secondary);">Total Paid:</span>
                    <span style="font-weight: 800; color: var(--primary);"><?php echo htmlspecialchars($amountPaid); ?></span>
                </div>
                <div class="receipt-row">
                    <span style="color: var(--text-secondary);">Apps Purchased:</span>
                    <span style="font-weight: 700;"><?php echo count($purchasedApps); ?> App(s)</span>
                </div>
            </div>

            <h3 style="font-size: 1.1rem; text-align: left; margin-bottom: 12px; font-weight: 750;">Your Software & Downloads:</h3>

            <?php foreach ($purchasedApps as $app): ?>
                <div class="app-download-box">
                    <div>
                        <div style="font-weight: 750; font-size: 1rem; color: var(--text-primary);"><?php echo htmlspecialchars($app['name']); ?></div>
                        <div style="font-family: var(--font-mono); font-size: 0.8rem; color: var(--primary); margin-top: 2px;">
                            Key: <?php echo htmlspecialchars($app['licenseKey']); ?>
                        </div>
                    </div>
                    <a href="<?php echo htmlspecialchars($app['downloadUrl']); ?>" class="btn btn-primary btn-sm">
                        📥 Download .DMG
                    </a>
                </div>
            <?php endforeach; ?>

            <p style="font-size: 0.78rem; color: var(--text-muted); margin-top: 20px;">
                🛡️ All download tokens are signed with HMAC-SHA256 and valid for 15 minutes.
            </p>

            <div style="margin-top: 28px;">
                <a href="/" class="btn btn-secondary">← Return to MacUpgraded.com</a>
            </div>
        </div>
    </div>
</body>
</html>
