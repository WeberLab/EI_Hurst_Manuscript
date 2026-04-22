# Reproducible quarto manuscript for "Does the Brain’s E:I Balance Really Shape Long-Range Temporal Correlations? Lessons Learned from 3T MRI"

This is a repo for generating our manuscript "Does the Brain’s E:I Balance Really Shape Long-Range Temporal Correlations? Lessons Learned from 3T MRI"

The best way to view this manuscript is at [weberlab.github.io/EI_Hurst_Manuscript/](https://weberlab.github.io/EI_Hurst_Manuscript/)

There you can view in HTML, or create the PDF or MSWord versions.

## Raw code

The raw code to create the manuscript is in `index.qmd`

Stats were produced in `notebooks/EI_Hurst_Revised.qmd` and some figures in `notebooks/Figure.ipynb`

# Steps to reproduce

## Clone this repo

`gh repo clone WeberLab/EI_Hurst`

## rv package manager for r

You will find an `rproject.toml` file in the main directory and the `notebooks` directory. These define the R version and the package to install.

You will need to install `rv`

Then run:

```bash
rv init .
rv sync
```

And do the same in `Notebooks`:

```bash
cd notebooks
rv init .
rv sync
```

## uv for Figures.ipynb

```bash
cd notebooks
uv sync
```

## Quarto

Now you can first preview, then render

```bash
quarto preview --no-browser #You don't need this flag; it just suppresses the browser from opening
quarto render
```

If you get some broken figure links, run `quarto preview` again
