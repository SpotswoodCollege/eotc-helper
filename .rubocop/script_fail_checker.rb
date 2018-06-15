if IO.readlines(".rubocop/out")[-1] == "Exited with status 1\n"
  throw "Oops. Looks as if some refactoring is necessary!"
end
