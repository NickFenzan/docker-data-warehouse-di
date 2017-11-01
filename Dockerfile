FROM mvnfenzan/pentaho-di
COPY pentaho /home/pentaho
CMD ["-job=Data Warehouse/Clean Import"]
