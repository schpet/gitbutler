<script lang="ts">
	import { FOCUS_MANAGER } from '$lib/focus/focusManager';
	import { inject } from '@gitbutler/shared/context';
	import { remToPx } from '@gitbutler/ui/utils/pxToRem';
	import { on } from 'svelte/events';

	const { cursor: target, outline } = inject(FOCUS_MANAGER);

	function isRelativePos(element: HTMLElement) {
		const style = element.computedStyleMap();
		const position = style.get('position')?.toString();
		return position === 'relative';
	}

	function setPosition(target: HTMLElement) {
		const element = document.createElement('div');
		element.classList.add('focus-cursor');

		const left = target.offsetLeft;
		const top = target.offsetTop;
		const width = target.clientWidth;
		const height = target.clientHeight;

		element.style.left = left ? left + 'px' : '';
		element.style.top = top ? top + 'px' : '';

		element.style.width = width + 'px';
		element.style.height = height + 'px';

		target.parentElement?.appendChild(element);
		return element;
	}

	$effect(() => {
		if ($target && $outline) {
			const element = setPosition($target);
			return () => element.remove();
		}
	});
	$effect(() => {
		if ($target) {
			return on(document, 'keypress', (e) => {
				if (e.key === '?') {
					outline.set(!$outline);
				}
			});
		}
	});
</script>

<style lang="postcss">
	:global(.focus-cursor) {
		z-index: 9999;
		position: absolute;

		/* Focus outline frame */
		border: 2px solid var(--clr-btn-pop-outline);
		border-radius: var(--radius-s);

		/* Transparent background - only outline frame */
		background: transparent;

		/* Initial state - hidden */
		pointer-events: none;

		/* Smooth transitions for position and size changes */
		transition: opacity 0.1s ease-in-out;
	}
</style>
