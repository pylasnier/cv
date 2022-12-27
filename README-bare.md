My CV.

Choose target for pandoc by running:

```
./target TARGET
```

which will set the target in the Makefile, i.e. converts from `src/TARGET.md` to `build/TARGET.pdf`, for example. Produce the CV in the specified output format using `make`:

```
make [ pdf | tex | gfm | readme | native ]
```

`pdf` is the default option. Choose `readme` to update this README file.

