<?php
/**
 * MacUpgraded.com - Payment Gateway & Security Configuration
 * Paste your live or test API keys from Stripe (stripe.com) and PayPal (developer.paypal.com).
 */

// Production Domain
define('SITE_URL', 'https://macupgraded.com');

// 1. STRIPE CONFIGURATION (For Apple Pay, Google Pay & Credit Cards)
// Get your API keys at: https://dashboard.stripe.com/apikeys
define('STRIPE_PUBLISHABLE_KEY', 'pk_live_REPLACE_WITH_YOUR_STRIPE_PUBLISHABLE_KEY');
define('STRIPE_SECRET_KEY', 'sk_live_REPLACE_WITH_YOUR_STRIPE_SECRET_KEY');
define('STRIPE_WEBHOOK_SECRET', 'whsec_REPLACE_WITH_YOUR_STRIPE_WEBHOOK_SECRET');

// 2. PAYPAL CONFIGURATION
// Get your credentials at: https://developer.paypal.com/dashboard/applications
define('PAYPAL_CLIENT_ID', 'REPLACE_WITH_YOUR_PAYPAL_CLIENT_ID');
define('PAYPAL_SECRET', 'REPLACE_WITH_YOUR_PAYPAL_SECRET');
define('PAYPAL_MODE', 'live'); // 'sandbox' or 'live'

// 3. CRYPTOGRAPHIC SECURITY SALTS (Keep these secret!)
define('MAC_UPGRADED_SECRET_SALT', 'MAC_UPGRADED_SECURE_TOKEN_SALT_2026_PRO');
define('SUITE_LICENSE_KEY_SECRET', 'MAC_SUITE_OFFLINE_VERIFY_KEY_2026');

// 4. STORAGE
define('PROTECTED_STORAGE_DIR', __DIR__ . '/protected_dmgs');
