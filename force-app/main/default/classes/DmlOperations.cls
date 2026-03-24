public inherited sharing class DmlOperations {

    public List<SObject> create(List<SObject> records){
        insert records;
        return records;
    }

    public SObject create(SObject record){
        insert record;
        return record;
    }
}