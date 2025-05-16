Param( [int32]$bl = 2000, [int32]$bb = 1200, [int32]$bh = 2000, [int32]$ch = 2000 )

$api = "http://127.0.0.1:9094/api/Developer"
$type = "scg"

$scriptBlock = {
    $url = "$api/Run?clear=1&bl=$bl&bb=$bb&bh=$bh&ch=$ch"
    curl $url --data-binary "@generatePart.ccscript" --header "Content-Type: application/octet-stream" -sS
    curl -sS -o ./out.$type "$api/Save?type=$type" -d ""
}
Measure-Command -Expression { & $scriptBlock }