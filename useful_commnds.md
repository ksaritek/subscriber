
```bash
$ rustup toolchain install nightly --allow-downgrade
$ cargo expand --test <filenam>
```

# llvm
install
```bash
brew install llvm
```

after installation
```bash
$ echo 'export PATH="/opt/homebrew/opt/llvm/bin:$PATH"' >> /Users/koray.sariteke/.zshrc
```
, for compilers to find llvm you may need to set
```bash
$ export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
$ export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
```

