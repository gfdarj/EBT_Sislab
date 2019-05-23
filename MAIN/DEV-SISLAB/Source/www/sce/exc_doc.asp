<!-- #INCLUDE FILE="includes/abre.asp" -->
<%ssql = "delete from sce_documentacao where doc_id = "& request("doc_id")
conn.execute(ssql)
response.redirect "alt_doc.asp?msg=2"%>