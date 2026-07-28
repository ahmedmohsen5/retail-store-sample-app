$directories = @(
    "../docker",
    "../compose",
    "../terraform",
    "../kubernetes",
    "../helm",
    "../gitops",
    "../monitoring",
    "../docs\architecture",
    "../docs\decisions",
    "../docs\runbooks"
)

foreach ($directory in $directories) {
    New-Item -ItemType Directory -Path $directory -Force | Out-Null

    if (-not (Get-ChildItem -Path $directory -Force -ErrorAction SilentlyContinue)) {
        New-Item -ItemType File `
            -Path (Join-Path $directory ".gitkeep") `
            -Force | Out-Null
    }
}