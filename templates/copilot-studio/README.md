# Copilot Studio Templates

This directory contains ready-to-use templates for building conversational AI agents using Microsoft Copilot Studio (formerly Power Virtual Agents). These templates are based on proven use cases from the AI Delivery Methodology.

## Overview

Microsoft Copilot Studio enables rapid development of intelligent chatbots and conversational agents without extensive coding. These templates provide:
- Pre-configured topics and intents
- Sample conversation flows
- Integration patterns with backend systems
- Best practices for enterprise deployment

## Available Templates

### Customer Service & Support
- **[Intelligent Virtual Banking Assistant](./banking-virtual-assistant.yaml)** - Financial services customer support
- **[Retail Shopping Assistant](./retail-shopping-assistant.yaml)** - E-commerce product discovery and support
- **[Call Center Agent Assist](./call-center-agent-assist.yaml)** - Real-time agent assistance

### Industry-Specific Solutions
- **[Financial Services](./financial-services/)** - Banking, insurance, wealth management
- **[Retail & E-commerce](./retail/)** - Customer service, product recommendations
- **[Healthcare](./healthcare/)** - Patient engagement, appointment scheduling

## How to Use These Templates

### 1. Import into Copilot Studio

1. Open [Microsoft Copilot Studio](https://copilotstudio.microsoft.com)
2. Create a new copilot or open an existing one
3. Go to **Topics** → **Add topic** → **From file**
4. Upload the template YAML file
5. Review and customize topics for your organization

### 2. Configure Intents

Each template includes pre-configured intents:
- **Trigger phrases** - How users start conversations
- **Entities** - Key information to extract (account numbers, product names)
- **Actions** - Backend system integrations
- **Response variations** - Natural conversation flows

### 3. Connect to Backend Systems

Templates include integration points for:
- **Azure OpenAI** - For generative AI responses
- **Power Automate flows** - For business logic
- **API connectors** - For CRM, ERP, knowledge bases
- **Microsoft Dataverse** - For data storage

### 4. Test and Deploy

1. Use **Test your copilot** panel to validate flows
2. Configure **Authentication** (Azure AD, OAuth)
3. Enable **Analytics** for performance monitoring
4. Deploy to channels:
   - Website embed
   - Microsoft Teams
   - Facebook Messenger
   - Custom applications

## Template Structure

Each template follows this standard structure:

```yaml
name: [Use Case Name]
description: [Brief description]
language: en-US
version: 1.0

topics:
  - name: [Topic Name]
    trigger_phrases:
      - [Sample user input]
    entities:
      - [Entity definitions]
    nodes:
      - [Conversation flow nodes]
    actions:
      - [Integration actions]

plugins:
  - [AI plugins and skills]

knowledge_sources:
  - [Website, SharePoint, documents]
```

## Best Practices

### Conversation Design
✅ Start with clear greeting and purpose statement  
✅ Use confirmation before actions (transfers, payments)  
✅ Provide fallback to human agent  
✅ Include context-aware responses  
✅ Support multi-turn conversations  
✅ Handle interruptions gracefully  

### Enterprise Deployment
✅ Enable authentication for sensitive operations  
✅ Configure compliance logging  
✅ Set up monitoring and alerts  
✅ Implement rate limiting  
✅ Test for security vulnerabilities  
✅ Plan for failover/redundancy  

### Performance Optimization
✅ Monitor containment rate (target: 70-85%)  
✅ Track customer satisfaction (target: >4.0/5)  
✅ Measure response time (target: <2 seconds)  
✅ Analyze escalation patterns  
✅ Continuously improve from analytics  

## Value Tracking

Use these templates with the [Value Analysis Agent](../../agents/) to track:
- **Cost savings** from automation
- **Customer satisfaction** improvements
- **Containment rate** (% resolved without human)
- **Response time** reduction
- **24/7 availability** value

## Related Resources

- [Business Envisioning Workshop Guide](../../guides/business-envisioning-workshop-guide.md)
- [Industry Use Cases - Financial Services](../../guides/industry-use-cases/financial-services-use-cases.md)
- [Industry Use Cases - Retail](../../guides/industry-use-cases/retail-use-cases.md)
- [Use Case Template](../14-business-envisioning-use-case-template.md)
- [OKRs Framework](../22-okrs-framework.md)

## Support

For questions or contributions:
- [GitHub Issues](https://github.com/andreaswasita/AI-Delivery-Methodology/issues)
- [Microsoft Copilot Studio Documentation](https://learn.microsoft.com/microsoft-copilot-studio/)
- [Azure OpenAI Integration Guide](https://learn.microsoft.com/azure/ai-services/openai/)

## License

MIT License - See repository root for details
