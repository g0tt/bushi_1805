#
# Build UTMC press
#
# Written by hyuga.
#

# 各種設定

##############################
# General settings here
##############################
# Text encoding
KANJI="utf8"
# Temporary directory
TMP_DIR="tmp"
# Compiled dvi or pdf file will be output here.
OUT_DIR="out"
# Target TeX file.
TARGET="utmcpress"
# Preview
PREVIEW="preview"

##############################
# Programs to use
##############################
MKDIR="mkdir"
RM="rm"
MV="mv"
PLATEX="platex"
DVIPDFMX="dvipdfmx"
DVIPNG="dvipng"
DVIGIF="dvigif"
PDFVIEWER="evince"
DVIVIEWER="xdvi"

help:
	@echo "Usage: make ( todvi | topdf | preview | clean | help )"
	@echo ""
	@echo "todvi     Compile the tex file and output dvi file."
	@echo "topdf     Compile the tex file and output pdf file."
	@echo "preview   Compile an article only, then shows dvi."
	@echo "clean     Clean temporary direcotry."
	@echo "help      Show this message."
	@echo ""
	@echo "See /Makefile for details."
	@echo "$@"

preview:
	# Override 'TARGET' macro.
	make showpdf TARGET=${PREVIEW}

todvi: clean
	@echo " * Compiling to dvi..."
	${MKDIR} -p ${TMP_DIR}
	${MKDIR} -p ${OUT_DIR}
	${MKDIR} -p ${TMP_DIR}/includes
	${MKDIR} -p ${TMP_DIR}/articles
	# Compile three times
	${PLATEX} -kanji=${KANJI} -output-directory="${TMP_DIR}" -interaction=nonstopmode "${TARGET}.tex"
	${PLATEX} -kanji=${KANJI} -output-directory="${TMP_DIR}" -interaction=nonstopmode "${TARGET}.tex"
	${PLATEX} -kanji=${KANJI} -output-directory="${TMP_DIR}" -interaction=nonstopmode "${TARGET}.tex"
	${MV} "${TMP_DIR}/${TARGET}.dvi" "${OUT_DIR}"

showdvi: todvi
	@echo " * Launching dvi viewer..."
	${DVIVIEWER} ${OUT_DIR}/${TARGET}.dvi

topdf: todvi
	@echo " * Converting dvi to pdf..."
	CURRENT=`pwd`
	cd ${OUT_DIR}; \
	${DVIPDFMX} -o ${TARGET}.pdf ${TARGET}.dvi

showpdf: topdf
	@echo " * Launching pdf viewer..."
	${PDFVIEWER} ${OUT_DIR}/${TARGET}.pdf

clean:
	@echo " * Cleaning the temporary direcotry..."
	${RM} -rf ${TMP_DIR}/*
	${RM} -rf ${OUT_DIR}/*
	${MKDIR} -p ${TMP_DIR}
	${MKDIR} -p ${OUT_DIR}
	${MKDIR} -p ${TMP_DIR}/includes
	${MKDIR} -p ${TMP_DIR}/articles

mypreview:
	${PLATEX} -kanji=${KANJI} -output-directory="${TMP_DIR}" -interaction=nonstopmode "${TARGET}.tex"
	${MV} "${TMP_DIR}/${TARGET}.dvi" "${OUT_DIR}"
