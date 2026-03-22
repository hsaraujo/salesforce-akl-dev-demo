/**
 * @author Heitor Araujo
 * @description THIS IS A DEMO CLASS. IT IS NOT MEANT TO BE USED IN PRODUCTION.
 */
public with sharing class DemoUtil {

    private static final Integer SLEEP_MS = 3000;

    public static void fakeSlowProcess(){

        // Convert desired delay into "work". We can't sleep, so we do CPU work.
        // This is intentionally wasteful: repeated hashing.
        Long start = DateTime.now().getTime();

        Blob seed = Blob.valueOf('demo-slow-mode-' + UserInfo.getUserId() + '-' + start);

        // Loop until time elapsed (bounded by CPU governor limit)
        // IMPORTANT: keep the targetMs small (like 500–3000ms) to avoid CPU limit.
        Integer iterations = 0;
        while (DateTime.now().getTime() - start < SLEEP_MS) {
            seed = Crypto.generateDigest('SHA-256', seed);
            iterations++;

            // Safety valve: avoid runaway loops if system time behaves oddly
            if (iterations > 200000) break;
        }

        System.debug('Fake slow process took ' + iterations + ' iterations.');
        System.debug('Time spent: ' + (DateTime.now().getTime() - start) + ' ms.');

    }
}