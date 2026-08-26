<?php
/**
 * MacUpgraded.com - Cryptographically Secured Tokenized Binary Streamer
 * Prevents hotlinking, scraping, directory traversal, and unauthorized binary distribution.
 */

// Strict error reporting disabled for production security
error_reporting(0);
ini_set('display_errors', 0);

// Secret Salt matching the backend authentication server
define('MAC_UPGRADED_SECRET_SALT', 'MAC_UPGRADED_SECURE_TOKEN_SALT_2026_PRO');
define('PROTECTED_STORAGE_DIR', __DIR__ . '/protected_dmgs');

// 1. Sanitize & Retrieve Input
$app = isset($_GET['app']) ? preg_replace('/[^a-z0-9\-]/', '', strtolower(trim($_GET['app']))) : '';
$token = isset($_GET['token']) ? preg_replace('/[^a-zA-Z0-9]/', '', trim($_GET['token'])) : '';
$expires = isset($_GET['expires']) ? intval($_GET['expires']) : 0;
$sig = isset($_GET['sig']) ? preg_replace('/[^a-f0-9]/', '', strtolower(trim($_GET['sig']))) : '';

// 2. Validate Parameters
if (empty($app) || empty($token) || empty($expires) || empty($sig)) {
    http_response_code(403);
    dieHeader('Access Denied: Missing or malformed secure download parameters.');
}

// 3. Verify Expiration Time (15-minute token lifetime)
if (time() > $expires) {
    http_response_code(410);
    dieHeader('Download Link Expired: This secure download token has expired for security reasons. Please refresh your purchase session.');
}

// 4. Verify Cryptographic HMAC Signature
$payload = "{$app}:{$token}:{$expires}";
$expectedSig = hash_hmac('sha256', $payload, MAC_UPGRADED_SECRET_SALT);

if (!hash_equals($expectedSig, $sig)) {
    http_response_code(403);
    dieHeader('Security Verification Failed: Invalid cryptographic token signature.');
}

// 5. Verify Binary File Existence
$filename = "{$app}-1.0.0.dmg";
$filepath = PROTECTED_STORAGE_DIR . '/' . $filename;

// Ensure realpath stays within protected storage directory (Anti-Directory Traversal)
$realStorage = realpath(PROTECTED_STORAGE_DIR);
$realFile = realpath($filepath);

if (!$realFile || strpos($realFile, $realStorage) !== 0 || !file_exists($realFile)) {
    http_response_code(404);
    dieHeader("Application build package ({$filename}) not found on secure storage server.");
}

// 6. Stream Binary Securely
$filesize = filesize($realFile);

// Clear output buffers
if (ob_get_level()) {
    ob_end_clean();
}

// Set Security & Download Headers
header('Content-Description: File Transfer');
header('Content-Type: application/x-apple-diskimage');
header('Content-Disposition: attachment; filename="' . basename($filename) . '"');
header('Content-Transfer-Encoding: binary');
header('Expires: 0');
header('Cache-Control: must-revalidate, post-check=0, pre-check=0, private');
header('Pragma: public');
header('Content-Length: ' . $filesize);
header('X-Content-Type-Options: nosniff');
header('X-Robots-Tag: noindex, nofollow, noarchive');

// Stream file in 8KB chunks
$chunkSize = 8192;
$handle = fopen($realFile, 'rb');

if ($handle === false) {
    http_response_code(500);
    dieHeader('Internal Server Error: Unable to read protected binary stream.');
}

while (!feof($handle)) {
    echo fread($handle, $chunkSize);
    flush();
}

fclose($handle);
exit;

function dieHeader($message) {
    echo "<!DOCTYPE html><html><head><title>MacUpgraded - Secure Download Gatekeeper</title>";
    echo "<style>body{background:#0b0f19;color:#f3f4f6;font-family:system-ui,-apple-system,sans-serif;display:flex;align-items:center;justify-content:center;height:100vh;margin:0;}";
    echo ".box{background:rgba(255,255,255,0.05);padding:32px 40px;border-radius:16px;border:1px solid rgba(255,255,255,0.1);max-width:480px;text-align:center;box-shadow:0 10px 40px rgba(0,0,0,0.5);}";
    echo "h2{color:#ef4444;margin-top:0;}p{color:#9ca3af;font-size:14px;line-height:1.6;}a{display:inline-block;margin-top:20px;padding:10px 24px;background:#3b82f6;color:#fff;text-decoration:none;border-radius:8px;font-weight:600;}</style></head>";
    echo "<body><div class='box'><h2>🔒 Security Notice</h2><p>" . htmlspecialchars($message) . "</p><a href='/'>Return to MacUpgraded.com</a></div></body></html>";
    exit;
}
