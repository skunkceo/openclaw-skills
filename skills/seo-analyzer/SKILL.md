# SEO Analyzer

Analyze pages for SEO issues and provide optimization recommendations.

## Usage

When asked to analyze SEO, audit a page, or check optimization:

1. Fetch the target URL
2. Analyze key SEO elements
3. Provide prioritized recommendations

## Analysis Checklist

### Title Tag
- Present? (required)
- Length: 50-60 characters ideal
- Contains target keyword?
- Unique across site?

### Meta Description
- Present? (recommended)
- Length: 150-160 characters ideal
- Contains target keyword?
- Compelling call-to-action?

### Heading Structure
- Single H1? (required)
- H1 contains primary keyword?
- Logical H2-H6 hierarchy?
- Keywords in subheadings?

### Content Analysis
- Word count (aim for 1000+ for core pages)
- Keyword density (1-3% target)
- Readability score
- Internal links present?
- External links to authoritative sources?

### Images
- Alt text on all images?
- Descriptive filenames?
- Compressed/optimized?
- Lazy loading enabled?

### Technical SEO
- Mobile-friendly?
- Page speed (Core Web Vitals)
- HTTPS enabled?
- Canonical URL set?
- Schema markup present?

### URL Structure
- Short and descriptive?
- Contains target keyword?
- No special characters?
- Lowercase?

## Commands

### Fetch Page Content
```bash
curl -s "URL" | head -500
```

### Check Mobile-Friendly (Google API)
```bash
curl "https://searchconsole.googleapis.com/v1/urlTestingTools/mobileFriendlyTest:run" \
  -H "Content-Type: application/json" \
  -d '{"url": "TARGET_URL"}'
```

### Check Page Speed
Use PageSpeed Insights API or Lighthouse CLI.

## Report Format

**SEO Analysis: [URL]**

**Overall Score: X/100**

**Critical Issues**
- [Issues that will hurt rankings]

**Improvements**
- [Opportunities for better optimization]

**Passed**
- [What's already optimized]

**Priority Actions**
1. [Most impactful fix first]
2. [Second priority]
3. [Third priority]

## Tips

- Compare against top-ranking competitors for the target keyword
- Check Google Search Console for existing performance data
- Consider search intent when evaluating content
