# PowerShell
param (
    # height of largest column without top bar
    [Parameter(Mandatory=$true)]
    [string]$imagename
)

Write-Host "Starting image $imagename"


if (-Not {podman network exists podify}) {
    podman network create podify
}

if ({podman container exists redis}) {
    podman rm -f redis
}
podman run -d -p 6379:6379 --net podify --name redis quay.io/podman-desktop-demo/podify-demo-backend:v1

if ({podman container exists python-frontend}) {
    podman rm -f python-frontend
}

#podman run -d -p 8088:5000 --net podify --name python-frontend quay.io/podman-desktop-demo/podify-demo-frontend:v1
podman run -d -p 8088:5000 --net podify --name python-frontend $imagename