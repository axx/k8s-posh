# This script retrieves the initial admin password for ArgoCD from a Kubernetes secret.

$namespace = "argocd"  # Change this if your ArgoCD is in a different namespace
$secretPassword = kubectl -n $namespace get secret argocd-initial-admin-secret -o jsonpath="{.data.password}"
$decodedPassword = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($secretPassword))
if ($decodedPassword) {
    Write-Host "### The initial admin password for ArgoCD is: $decodedPassword"
}
else {
    Write-Host "### Failed to retrieve the initial admin password for ArgoCD. Please check if ArgoCD is installed and the secret exists."
}