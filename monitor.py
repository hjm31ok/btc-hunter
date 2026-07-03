import http.server
import socketserver
import os

PORT = 39105 # 你可以在浏览器通过 IP:8080 访问

class MyHandler(http.server.SimpleHTTPRequestHandler):
    def end_headers(self):
        self.send_header('Access-Control-Allow-Origin', '*')
        super().end_headers()

print(f"[*] 监控网页已启动: http://你的服务器IP:{PORT}")
with socketserver.TCPServer(("", PORT), MyHandler) as httpd:
    httpd.serve_forever()