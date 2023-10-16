/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: "class",
	content: ['./**/*.{astro,html,js,jsx,md,svelte,ts,tsx,vue}'],
  theme: {
		extend: {
      screens: {
        'prose': '80ch', // max-w-prose
        'md': '640px', // tablet
        'lg': '1024px', // computer
        'xl': '1280px', // large computer
      },
      maxWidth: {
        'md': '640px',
        'lg': '1024px',
        'xl': '1280px',
        'prose': '80ch', // max-w-prose
      },
			fontFamily: {
				sans: ["Poppins", "sans-serif"],
        poppins: ["Poppins", "sans-serif"],
				marker: ["Permanent Marker", "cursive"],
			},
			colors: {
				"picton-blue": {
					50: "#f2fbff",
					100: "#e6f8ff",
					200: "#bfedff",
					300: "#99e2ff",
					400: "#4dcdff",
					500: "#00b7ff",
					600: "#00a5e6",
					700: "#0089bf",
					800: "#006e99",
					900: "#005a7d",
				},
				"violet-red": {
					50: "#fff5f9",
					100: "#ffebf2",
					200: "#ffcde0",
					300: "#ffafcd",
					400: "#ff74a7",
					500: "#ff3881",
					600: "#e63274",
					700: "#bf2a61",
					800: "#99224d",
					900: "#7d1b3f",
				},
				'sun': {
          50: "#fffbf3",
					100: "#fff7e8",
					200: "#ffebc5",
					300: "#ffdfa3",
					400: "#ffc75d",
					500: "#ffaf18",
					600: "#e69e16",
					700: "#bf8312",
					800: "#99690e",
					900: "#7d560c",
				},
				"electric-violet": {
					50: "#f9f4ff",
					100: "#f3e9ff",
					200: "#e1c7ff",
					300: "#cfa5ff",
					400: "#ab62ff",
					500: "#871EFF",
					600: "#7a1be6",
					700: "#6517bf",
					800: "#511299",
					900: "#420f7d",
				},
        'fern': {
          '50': '#f7fbf8', 
          '100': '#f0f7f1', 
          '200': '#d9ecdb', 
          '300': '#c2e0c6', 
          '400': '#95c99b', 
          '500': '#67b270', 
          '600': '#5da065', 
          '700': '#4d8654', 
          '800': '#3e6b43', 
          '900': '#325737'
        }
			},
		},
	},
	plugins: [require("@tailwindcss/typography")],
}
