# Chapter 22 — OCR (tesseract shell-out)

**You'll learn:** OCR is a deep ML problem. Don't reinvent — `tesseract` is the standard open-source engine, and you call it from Idris by shelling out: `tesseract input.png output.txt -l eng`. Then read the resulting text file.

## Idris realization

```idris
ocr : (imagePath : String) -> IO (Either String String)
ocr p = do
  let tmp = "/tmp/ocr_out"
  exit <- system ("tesseract " ++ p ++ " " ++ tmp ++ " -l eng 2>/dev/null")
  if exit /= 0
    then pure (Left ("tesseract failed on " ++ p))
    else do
      Right txt <- readFile (tmp ++ ".txt")
        | Left err => pure (Left (show err))
      pure (Right txt)
```

## External tool dependency

`tesseract` — `sudo apt install tesseract-ocr` (Ubuntu) or `brew install tesseract` (macOS).

## Pack dependencies

None.

## Miniproject

Receipt scanner: take a folder of receipt photos, OCR each one, extract the total via parser combinators, write a TSV of `(filename, total)` rows.
