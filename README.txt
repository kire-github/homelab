To make Headscale advertise exit nodes:
"""
docker exec headscale headscale nodes list-routes
docker exec headscale headscale nodes approve-routes --identifier <ID> --routes "0.0.0.0/0,::/0"
"""

To verify that it works:
"""
docker exec tailscale tailscale status
"""