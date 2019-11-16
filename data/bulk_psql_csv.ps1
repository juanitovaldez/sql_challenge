$files = @(Get-ChildItem C:\Users\Juan\bootcamp\Homework\homework_07\data\*.csv)
foreach ($file in $files) {$file}