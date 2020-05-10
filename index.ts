import * as awsx from '@pulumi/awsx';

// Create a load balancer to listen for requests and route them to the container.
let lb = new awsx.lb.NetworkListener('haskell', { port: 80 });
let service = new awsx.ecs.FargateService('haskell', {
    desiredCount: 1,
    taskDefinitionArgs: {
        containers: {
            haskell: {
                image: awsx.ecs.Image.fromPath('haskell', './app'),
                memory: 512,
                portMappings: [ lb ]
            }
        }
    }
});

// Export the URL so we can easily access it.
export const url = lb.endpoint.hostname;