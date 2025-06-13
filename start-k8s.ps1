# This script checks if Podman and Minikube are running, and starts them if they are not.

# Check if podman is started
$podmanStatus = podman info 2>&1
if ($podmanStatus -match "Error:") {
    Write-Host "### Podman is not running. Starting Podman..."
    $podmanProcess = (Start-Process "podman" -ArgumentList "machine", "start" -NoNewWindow -PassThru | Wait-Process -PassThru)
    $podmanProcess.WaitForExit()
    # Check if Podman started successfully
    if ($podmanProcess.ExitCode -ne 0) {
        Write-Host "### Failed to start Podman. Please check your Podman installation."
        exit 1
    }
    else {
        Write-Host "### Podman started successfully."
    }
}
else {
    Write-Host "### Podman is already running."
}

# Start minikube
$minikubeStatus = minikube status --format "{{.Host}}"
if ($minikubeStatus -ne "Running") {
    Write-Host "### Minikube is not running. Starting Minikube..."
    $minikubeProcess = (Start-Process "minikube" -ArgumentList "start", "--driver=podman", "--container-runtime=cri-o" -NoNewWindow -PassThru | Wait-Process -PassThru)
    $minikubeProcess.WaitForExit()
    # Check if Minikube started successfully
    if ($minikubeProcess.ExitCode -ne 0) {
        Write-Host "### Failed to start Minikube. Please check your Minikube installation."
        exit 1
    }
    else {
        Write-Host "### Minikube started successfully."
    }
}
else {
    Write-Host "### Minikube is already running."
}
