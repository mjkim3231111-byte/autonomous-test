Add-Type -AssemblyName System.Drawing
$width = 256
$height = 256

# 사용자가 실제로 수업 및 대시보드 화면에서 본 컬러 이모지들 매핑
$icons = @{
    "guide_card_icon.png" = "🧑‍🏫"
    "quiz_card_icon.png" = "📖"
    "rocket_card_icon.png" = "🚀"
    "tv_card_icon.png" = "📺"
    "dashboard_card_icon.png" = "📊"
    "survey_card_icon.png" = "📝"
    "arrow_icon.png" = "➡️"
    "car_icon.png" = "🚗"
    "reset_icon.png" = "🔄"
    "light_icon.png" = "💡"
    "phone_icon.png" = "📱"
    "screen_icon.png" = "🖥️"
    "racing_car_icon.png" = "🏎️"
    "crown_icon.png" = "👑"
    "check_icon.png" = "✅"
    "cross_icon.png" = "❌"
    "school_icon.png" = "🏫"
    "trophy_icon.png" = "🏆"
    "report_icon.png" = "📊"
    "mentor_robot_icon.png" = "🤖"
    "red_car_icon.png" = "🚗"
    "straight_road_icon.png" = "🛣️"
    "pin_icon.png" = "📌"
    "speaker_icon.png" = "🔊"
    "triangle_ruler_icon.png" = "📐"
    "wrench_icon.png" = "🔧"
    "qr_phone_icon.png" = "📲"
    "live_status_icon.png" = "🟢"
    "exam_icon.png" = "📝"
    "camera_icon.png" = "📷"
    "megaphone_icon.png" = "📢"
    "gear_icon.png" = "⚙️"
    "lightning_icon.png" = "⚡"
    "gold_medal_icon.png" = "🥇"
    "silver_medal_icon.png" = "🥈"
    "bronze_medal_icon.png" = "🥉"
    "line_chart_icon.png" = "📈"
    "document_icon.png" = "📄"
    "teacher_avatar_icon.png" = "🧑‍🏫"
    "star_rating_icon.png" = "⭐"
    "abacus_icon.png" = "🧮"
}

$currentDir = (Get-Item -Path ".").FullName

foreach ($file in $icons.Keys) {
    $bmp = New-Object System.Drawing.Bitmap($width, $height)
    $graphics = [System.Drawing.Graphics]::FromImage($bmp)
    
    # 이모지 픽셀 경계 안티앨리어싱
    $graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
    
    # 배경을 투명(Transparent)하게 지우기
    $graphics.Clear([System.Drawing.Color]::Transparent)
    
    # Segoe UI Emoji 폰트 적용
    $font = New-Object System.Drawing.Font("Segoe UI Emoji", 110)
    $brush = New-Object System.Drawing.SolidBrush([System.Drawing.Color]::Black)
    
    # 정중앙 정렬
    $sf = New-Object System.Drawing.StringFormat
    $sf.Alignment = [System.Drawing.StringAlignment]::Center
    $sf.LineAlignment = [System.Drawing.StringAlignment]::Center
    
    $emoji = $icons[$file]
    $rect = New-Object System.Drawing.RectangleF(0, 0, $width, $height)
    $graphics.DrawString($emoji, $font, $brush, $rect, $sf)
    
    # 투명 PNG 파일로 저장
    $targetPath = Join-Path -Path $currentDir -ChildPath "picture\$file"
    $bmp.Save($targetPath, [System.Drawing.Imaging.ImageFormat]::Png)
    
    $font.Dispose()
    $brush.Dispose()
    $sf.Dispose()
    $graphics.Dispose()
    $bmp.Dispose()
}
