Build using

```
lake exe repro --output _out --with-html-single --without-html-multi
```

serve it via

```
python3 -m http.server -d _out/html-single
```

and observe that the links in the table of contents do not actually point at the relevant sections.
