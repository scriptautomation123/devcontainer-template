#!/usr/bin/env python3
import socket
import threading
import time

def handle_client(client_socket, addr):
    print(f"Connection from {addr}")
    try:
        while True:
            data = client_socket.recv(1024)
            if not data:
                break
            # Simple mock LDAP response
            client_socket.send(b"Mock LDAP response\n")
    except Exception as e:
        print(f"Error handling client {addr}: {e}")
    finally:
        client_socket.close()

def start_server():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server.bind(('0.0.0.0', 1389))
    server.listen(5)
    print("Mock LDAP server listening on port 1389")
    
    while True:
        client_socket, addr = server.accept()
        client_thread = threading.Thread(target=handle_client, args=(client_socket, addr))
        client_thread.start()

if __name__ == "__main__":
    start_server()
