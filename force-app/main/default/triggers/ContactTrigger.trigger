trigger ContactTrigger on Contact (before insert) {
    DemoUtil.fakeSlowProcess();
}