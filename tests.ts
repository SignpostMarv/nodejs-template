import {
	tap,
} from 'node:test/reporters';
import {
	run,
} from 'node:test';

const ac = new AbortController();

let already_stopped = false;

run({
	files: [
	],
	concurrency: true,
	signal: ac.signal,
})
	.on('test:fail', (e) => {
		ac.abort();
		if (!already_stopped) {
			console.error(e);
		}
		already_stopped = true;
		process.exitCode = 1;
	})
	.compose(tap)
	.pipe(process.stdout);
