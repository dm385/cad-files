$api = "http://127.0.0.1:9094/api"
$csv = Import-Csv -Path "./shelf.csv"
$dir = "../.out/shelf"
if (Test-Path -Path $dir) {
    Remove-Item -Path $dir -Recurse -Force
}
foreach ($line in $csv) {
    $name = "$($line.length)-$($line.depth)"
    $out = "$dir"
    New-Item -Path $out -ItemType Directory -Force
    $url = "$api/Developer/Run?clear=1&length=$($line.length)&depth=$($line.depth)&ft=$($line.ft)"
    curl $url --data-binary "@shelf.ccfunc" --header "Content-Type: application/octet-stream" -sS
    curl -sS -o "$out/$name.ofb" "$api/Developer/Save?type=ofb" -d ""
}
