predmeti := moderna-fizika uvod-v-funkcionalno-analizo teorija-izracunljivosti teorija-grafov statistika-2
ksl := moderna-fizika uvod-v-funkcionalno-analizo teorija-grafov

latex-cmd := lualatex --shell-escape

predmeti-filenames := $(foreach predmet,$(predmeti),zapiski-$(predmet).pdf)
ksl-filenames := $(foreach predmet,$(ksl),ksl-$(predmet).pdf)

all: $(predmeti-filenames) $(ksl-filenames) zapiski.pdf

zbt-templates: $(wildcard templates/*.tex)
	touch zbt-templates

$(predmeti-filenames): zapiski-%.pdf: zapiski-%.tex
	$(latex-cmd) $^

zapiski-%.tex: zbt-templates predmeti/%/*.tex
	cat templates/predmet-1.tex > $@
	cat templates/skupno.tex >> $@
	cat predmeti/$*/predmet.tex >> $@
	cat templates/predmet-2.tex >> $@
	cat predmeti/$*/all.tex >> $@
	cat templates/predmet-3.tex >> $@

zapiski.pdf: zapiski.tex predmeti.tex $(predmeti-filenames)
	$(latex-cmd) $^

$(ksl-filenames): ksl-%.pdf: ksl-%.tex
	$(latex-cmd) $^

ksl-%.tex: zbt-templates ksl/%/*.tex
	cat templates/kslt-1.tex > $@
	cat templates/skupno.tex >> $@
	cat ksl/$*/ksl.tex >> $@
	cat templates/kslt-2.tex >> $@
	cat ksl/$*/all.tex >> $@
	cat templates/kslt-3.tex >> $@

.PHONY: clean
clean:
	rm -f *.log *.aux *.out *.gnuplot *.table *.toc
	rm -f zapiski-*.tex
	rm -f ksl-*.tex
	rm -f zbt-*
