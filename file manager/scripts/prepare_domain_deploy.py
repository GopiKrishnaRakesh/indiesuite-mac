#!/usr/bin/env python3
"""
Prepares the Pathway website for deployment to any custom domain.
Bundles index.html, styles.css, app.js, assets, and server configs (.htaccess, robots.txt, sitemap.xml, etc.)
into dist/deploy_website and creates a ready-to-upload dist/Pathway_Website_Deploy.zip.
"""

import os
import shutil
import zipfile

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.dirname(SCRIPT_DIR)
WEBSITE_DIR = os.path.join(PROJECT_DIR, "website")
DIST_DIR = os.path.join(PROJECT_DIR, "dist")
DEPLOY_DIR = os.path.join(DIST_DIR, "deploy_website")
ZIP_PATH = os.path.join(DIST_DIR, "Pathway_Website_Deploy.zip")

def prepare_deploy():
    print(f"📦 Packaging website from: {WEBSITE_DIR}")
    
    if os.path.exists(DEPLOY_DIR):
        shutil.rmtree(DEPLOY_DIR)
    os.makedirs(DEPLOY_DIR, exist_ok=True)
    
    # Items to copy to deployment root
    items_to_copy = [
        "index.html",
        "styles.css",
        "app.js",
        "privacy.html",
        "site.webmanifest",
        "robots.txt",
        "sitemap.xml",
        ".htaccess",
        "_headers",
        "vercel.json",
        "assets"
    ]
    
    for item in items_to_copy:
        src = os.path.join(WEBSITE_DIR, item)
        dst = os.path.join(DEPLOY_DIR, item)
        if os.path.isfile(src):
            shutil.copy2(src, dst)
            print(f"  ✓ Copied file: {item}")
        elif os.path.isdir(src):
            shutil.copytree(src, dst)
            print(f"  ✓ Copied dir: {item}/")
            
    # Include all local downloads (DMGs and ZIPs)
    downloads_src = os.path.join(WEBSITE_DIR, "downloads")
    if os.path.exists(downloads_src):
        dst_downloads = os.path.join(DEPLOY_DIR, "downloads")
        os.makedirs(dst_downloads, exist_ok=True)
        for f in os.listdir(downloads_src):
            s = os.path.join(downloads_src, f)
            if os.path.isfile(s) and not f.startswith("."):
                shutil.copy2(s, os.path.join(dst_downloads, f))
                print(f"  ✓ Included downloads/{f}")

    # Create ZIP bundle
    if os.path.exists(ZIP_PATH):
        os.remove(ZIP_PATH)
        
    print(f"\n🤐 Creating deployment archive: {ZIP_PATH}")
    with zipfile.ZipFile(ZIP_PATH, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for root, dirs, files in os.walk(DEPLOY_DIR):
            for file in files:
                abs_path = os.path.join(root, file)
                rel_path = os.path.relpath(abs_path, DEPLOY_DIR)
                zipf.write(abs_path, rel_path)
                
    zip_size_mb = os.path.getsize(ZIP_PATH) / (1024 * 1024)
    print(f"✓ Standalone deployment zip created: {ZIP_PATH} ({zip_size_mb:.2f} MB)")
    print(f"✓ Production folder ready at: {DEPLOY_DIR}")

if __name__ == "__main__":
    prepare_deploy()
