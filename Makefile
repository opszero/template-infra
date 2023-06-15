fmt:
	terraform fmt -recursive

diagram-pdf:
	jupyter nbconvert --to pdf --TemplateExporter.exclude_input=True ./DIAGRAM.ipynb