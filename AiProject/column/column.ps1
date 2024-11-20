$api = "http://127.0.0.1:9094/api"
$csv = Import-Csv -Path "./column.csv"
$dir = "../.out/column"
if (Test-Path -Path $dir) {
    Remove-Item -Path $dir -Recurse -Force
}
foreach ($line in $csv) {
    $name = "$($line.height)-$($line.length)-$($line.depth)"
    $out = "$dir"
    New-Item -Path $out -ItemType Directory -Force
    $url = "$api/Developer/Run?clear=1&height=$($line.height)&length=$($line.length)&depth=$($line.depth)"
    curl $url --data-binary "@column.ccfunc" --header "Content-Type: application/octet-stream" -sS
    curl -sS -o "$out/$name.ofb" "$api/Developer/Save?type=ofb" -d ""
    curl -sS -o "$out/$name.stp" "$api/Developer/Save?type=stp" -d ""
    curl -sS -o "$out/$name.iwb" "$api/Developer/Save?type=iwb" -d ""
}
