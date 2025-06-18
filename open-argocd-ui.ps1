# This script sets up port forwarding for the ArgoCD UI and opens it in the default web browser.

$port = 8080
Start-Job -ScriptBlock {
    # Run port forwarding in the background
    $namespace = "argocd"  # Change this if your ArgoCD is in a different namespace
    kubectl port-forward svc/argocd-server -n $namespace $port:443
}
# Wait for the port forwarding to be established
Start-Sleep -Seconds 5
# Open the ArgoCD UI in the default web browser
Start-Process "http://localhost:$port"
