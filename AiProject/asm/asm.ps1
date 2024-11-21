$api = "http://127.0.0.1:9094/api"
$csv = Import-Csv -Path "./asm.csv"
$dir = "../.out/asm"
if (Test-Path -Path $dir) {
    Remove-Item -Path $dir -Recurse -Force
}
foreach ($line in $csv) {
    $name = "asm-$($line.id)"
    $out = "$dir"
    New-Item -Path $out -ItemType Directory -Force
    $url = "$api/Developer/Run?clear=1&height=$($line.height)&depth=$($line.depth)&length=$($line.length)&nShelves=$($line.nShelves)&col_file=$($line.col_file)&shelf_file=$($line.shelf_file)&dir=AiProject/.out/"
    curl $url --data-binary "@asm.ccfunc" --header "Content-Type: application/octet-stream" -sS 
    curl -sS -o "$out/$name.ofb" "$api/BaseModelerAPI_v1/save?file=ofb" -d ""
    curl -sS -o "$out/$name.iwb" "$api/BaseModelerAPI_v1/save?file=iwb" -d "{"asPart": true, "useAsciiFile": false "}"
}
