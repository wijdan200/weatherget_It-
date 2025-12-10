#!/usr/bin/env python3
"""
Simple HTTP server to test deep links on Android phone.
Run this script, then access it from your phone using your computer's IP address.
"""
import http.server
import socketserver
import webbrowser
import socket

PORT = 8000

class MyHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        super().end_headers()

def get_local_ip():
    """Get the local IP address"""
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        # Connect to a remote address (doesn't actually connect)
        s.connect(('8.8.8.8', 80))
        ip = s.getsockname()[0]
    except Exception:
        ip = '127.0.0.1'
    finally:
        s.close()
    return ip

if __name__ == "__main__":
    handler = MyHTTPRequestHandler
    
    with socketserver.TCPServer(("", PORT), handler) as httpd:
        local_ip = get_local_ip()
        print("=" * 60)
        print("🌐 Deep Link Test Server Started!")
        print("=" * 60)
        print(f"📱 On your Android phone, open Chrome and go to:")
        print(f"   http://{local_ip}:{PORT}/deep_link_test.html")
        print("=" * 60)
        print(f"💻 Or open in your computer browser:")
        print(f"   http://localhost:{PORT}/deep_link_test.html")
        print("=" * 60)
        print("Press Ctrl+C to stop the server")
        print("=" * 60)
        
        # Open in browser automatically
        try:
            webbrowser.open(f'http://localhost:{PORT}/deep_link_test.html')
        except:
            pass
        
        httpd.serve_forever()









