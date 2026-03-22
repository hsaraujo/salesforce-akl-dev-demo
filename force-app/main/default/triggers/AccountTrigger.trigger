trigger AccountTrigger on Account (before insert) {
    DemoUtil.fakeSlowProcess();
}