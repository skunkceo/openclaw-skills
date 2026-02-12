# SEO Analyzer

Analyze web pages for SEO issues and get prioritized optimization recommendations.

## What It Does

- Audit title tags, meta descriptions, and headings
- Check keyword usage and density
- Analyze content length and readability
- Verify image alt tags and optimization
- Check internal/external linking
- Identify technical SEO issues

## Installation

```bash
skunk install seo-analyzer
```

## Requirements

None — works with OpenClaw's built-in web fetching.

## Usage

Ask naturally:

- "Analyze the SEO of skunkcrm.com/features"
- "Check if this page is optimized for 'wordpress crm'"
- "Audit the meta tags on our pricing page"
- "What SEO improvements does this blog post need?"

## Example Output

**SEO Analysis: example.com/features**

**Issues Found**
- Title tag too long (72 chars, aim for 50-60)
- Missing meta description
- No H1 tag on page

**Warnings**
- Low word count (450 words, aim for 1000+)
- Only 1 internal link
- 3 images missing alt text

**Passed**
- HTTPS enabled
- Mobile responsive
- Good heading hierarchy (H2-H4)

**Recommendations**
1. Add compelling meta description with target keyword
2. Shorten title to under 60 characters
3. Add H1 with primary keyword

## Tags

`seo` `analysis` `optimization` `meta-tags` `keywords`

## Author

[Skunk Global](https://skunkglobal.com)
