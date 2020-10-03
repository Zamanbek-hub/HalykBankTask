import os
import fitz


def readPdf():
    file_path = "./HOME_TASK_2.pdf"
    
    # check to file exist
    if os.path.isfile(file_path): 
        doc = fitz.open(file_path)
        
        for i in range(len(doc)):
            for img in doc.getPageImageList(i):
                xref = img[0]  
                pix = fitz.Pixmap(doc, xref)
                pix.writePNG("%s.png" % (xref))
        
        text = ""
        for page in doc:
            text += page.getText()

        return text     
    else:
        return "No such file or directory"


print(readPdf())