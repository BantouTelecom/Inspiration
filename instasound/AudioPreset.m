#import "AudioPreset.h"

@implementation AudioPreset

@synthesize enabled;

- (AudioPreset *) create:(AUGraph) _graph
{
    graph = _graph;

    [self initDescriptions];

    enabled = NO;

    AUGraphAddNode(graph, &reverb_desc, &reverbNode);
    AUGraphAddNode(graph, &compression_desc, &compressionNode);
    AUGraphAddNode(graph, &bandpass_desc, &bandpassNode);
    AUGraphAddNode(graph, &distortion_desc, &distortionNode);

    AUGraphNodeInfo(graph, distortionNode, NULL, &distortionUnit);
    AUGraphNodeInfo(graph, compressionNode, NULL, &compressionUnit);
    AUGraphNodeInfo(graph, reverbNode, NULL, &reverbUnit);
    AUGraphNodeInfo(graph, bandpassNode, NULL, &bandpassUnit);

    return self;
}


- (AudioPreset *) connect:(AUNode)input with:(AUNode)output on:(int)channel
{
    AUGraphConnectNodeInput(graph, input, 0, bandpassNode, 0);
    AUGraphConnectNodeInput(graph, bandpassNode, 0, compressionNode, 0);
    AUGraphConnectNodeInput(graph, compressionNode, 0, distortionNode, 0);
    AUGraphConnectNodeInput(graph, distortionNode, 0, reverbNode, 0);
    AUGraphConnectNodeInput(graph, reverbNode, 0, output, channel);

    return self;
}

- (AudioPreset *) disconnect:(AUNode)output;
{
    return self;
}

- (void) initDescriptions
{
    distortion_desc.componentType               = kAudioUnitType_Effect;
    distortion_desc.componentSubType            = kAudioUnitSubType_Distortion;
    distortion_desc.componentFlags              = 0;
    distortion_desc.componentFlagsMask          = 0;
    distortion_desc.componentManufacturer       = kAudioUnitManufacturer_Apple;

    reverb_desc.componentType                   = kAudioUnitType_Effect;
    reverb_desc.componentSubType                = kAudioUnitSubType_Reverb2;
    reverb_desc.componentFlags                  = 0;
    reverb_desc.componentFlagsMask              = 0;
    reverb_desc.componentManufacturer           = kAudioUnitManufacturer_Apple;

    compression_desc.componentType              = kAudioUnitType_Effect;
    compression_desc.componentSubType           = kAudioUnitSubType_DynamicsProcessor;
    compression_desc.componentFlags             = 0;
    compression_desc.componentFlagsMask         = 0;
    compression_desc.componentManufacturer      = kAudioUnitManufacturer_Apple;

    bandpass_desc.componentType                 = kAudioUnitType_Effect;
    bandpass_desc.componentSubType              = kAudioUnitSubType_BandPassFilter;
    bandpass_desc.componentFlags                = 0;
    bandpass_desc.componentFlagsMask            = 0;
    bandpass_desc.componentManufacturer         = kAudioUnitManufacturer_Apple;
}

- (id) distortion: (AudioUnitParameterID)type to:(AudioUnitParameterValue) value
{
    AudioUnitSetParameter(distortionUnit, type, kAudioUnitScope_Global, 0, value, 0);
    return self;
}

- (id) reverb: (AudioUnitParameterID)type to:(AudioUnitParameterValue) value
{
    AudioUnitSetParameter(reverbUnit, type, kAudioUnitScope_Global, 0, value, 0);
    return self;
}

- (id) compression: (AudioUnitParameterID)type to:(AudioUnitParameterValue) value
{
    AudioUnitSetParameter(compressionUnit, type, kAudioUnitScope_Global, 0, value, 0);
    return self;
}

- (id) bandpass: (AudioUnitParameterID)type to:(AudioUnitParameterValue) value
{
    AudioUnitSetParameter(bandpassUnit, type, kAudioUnitScope_Global, 0, value, 0);
    return self;
}

@end
