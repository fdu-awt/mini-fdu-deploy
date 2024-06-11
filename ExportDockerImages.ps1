# 定义一个包含Docker镜像名称的数组
$imageArray = @(
    "mysql:8.0.34",
    "zmarkgo/mini-fdu-user:1.0.0",
    "zmarkgo/mini-fdu-study:1.0.0",
    "zmarkgo/mini-fdu-socket:1.0.0",
    "zmarkgo/mini-fdu-ai:1.0.0",
    "zmarkgo/mini-fdu-gateway:1.0.0",
    "zmarkgo/mini-fdu-front:1.0.0"
)
$exportFileArray = @(
    "mysql-8.0.34",
    "mini-fdu-user-1.0.0",
    "mini-fdu-study-1.0.0",
    "mini-fdu-socket-1.0.0",
    "mini-fdu-ai-1.0.0",
    "mini-fdu-gateway-1.0.0",
    "mini-fdu-front-1.0.0"
)
$exportDir = "./images"
# 创建目录
if (!(Test-Path $exportDir)) {
    New-Item -ItemType Directory -Path $exportDir
}
# 导出镜像
for ($i = 0; $i -lt $imageArray.Length; $i++) {
    $imageName = $imageArray[$i]
    $exportFile = $exportDir + "/" + $exportFileArray[$i]
    docker save -o $exportFile $imageName
    Write-Host "Export image($imageName) to $exportFile"
}