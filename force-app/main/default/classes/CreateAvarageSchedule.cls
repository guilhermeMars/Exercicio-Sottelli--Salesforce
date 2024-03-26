public with sharing class CreateAvarageSchedule implements Schedulable{
    public void execute(SchedulableContext context){
        CreateAverage.inserirMedia();
    }
    // Debug Console
    /*
    CreateAvarageSchedule createAve = new CreateAvarageSchedule();
    string sch = '0 0 17 * * ? *';
    System.schedule('WarehouseSyncScheduleJob', sch, createAve);
    */
}