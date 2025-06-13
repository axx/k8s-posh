# This script stops Minikube and Podman on a Windows system.

$stopK8sProcess = (Start-Process "minikube" -ArgumentList "stop" -NoNewWindow -PassThru | Wait-Process -PassThru)
$stopK8sProcess.WaitForExit()

# Check if Minikube stopped successfully
if ($stopK8sProcess.ExitCode -ne 0) {
    Write-Host "### Failed to stop Minikube. Please check your Minikube installation."
    exit 1
}
else {
    Write-Host "### Minikube stopped successfully."
}

# Stop Podman
$stopPodmanProcess = (Start-Process "podman" -ArgumentList "machine", "stop" -NoNewWindow -PassThru | Wait-Process -PassThru)
$stopPodmanProcess.WaitForExit()

# Check if Podman stopped successfully
if ($stopPodmanProcess.ExitCode -ne 0) {
    Write-Host "### Failed to stop Podman. Please check your Podman installation."
    exit 1
}
else {
    Write-Host "### Podman stopped successfully."
}
