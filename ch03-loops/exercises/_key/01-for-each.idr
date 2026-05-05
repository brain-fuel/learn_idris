module Main

%default total

main : IO ()
main = for_ ["Alice", "Bob", "Carol"] $ \name => putStrLn ("Hi, " ++ name)
