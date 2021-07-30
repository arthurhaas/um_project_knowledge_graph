# to install

download latest rmlmapper:

https://github.com/RMLio/rmlmapper-java/releases


follow these steps for YARRRML:

https://rml.io/yarrrml/tutorial/getting-started/#writing-rules-on-your-computer


# preprocessing

Execute the ../../data/happiness_report/preprocessing_happy.ipynb file to receive the necessary `data/happiness_report/2019_preprocessed.csv`


# to execute for mapping

```bash
yarrrml-parser -i mapping_happy.yarrrml.yml -o mapping_happy.rml.ttl
java -jar ../rmlmapper-4.9.2.jar -m mapping_happy.rml.ttl -o output.mapping_happy.ttl -s turtle
```