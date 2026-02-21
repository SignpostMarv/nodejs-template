import {
	typescript,
} from '@signpostmarv/eslint-config';

const config = [
	{
		languageOptions: {
			parser: '@typescript-eslint/parser',
			parserOptions: {
				project: ['./tsconfig.eslint.json'],
			},
		},
	},
	...typescript,
	{
		files: ['**/*.ts'],
		ignores: ['**/*.d.ts', '**/*.js', '**/*.mjs'],
	},
];


export default config;
