
#import "AudioToolbox/AudioToolbox.h"
#import <Foundation/Foundation.h>

@interface AudioPreset : NSObject
{
    AUGraph graph;
    Boolean enabled;
    
    AudioComponentDescription distortion_desc;
    AudioComponentDescription reverb_desc;
    AudioComponentDescription compression_desc;
    AudioComponentDescription bandpass_desc;
    
    AUNode distortionNode;
    AUNode reverbNode;
    AUNode compressionNode;
    AUNode bandpassNode;
    
    AudioUnit distortionUnit;
    AudioUnit reverbUnit;
    AudioUnit compressionUnit;
    AudioUnit bandpassUnit;
}

@property (atomic) Boolean enabled;

- (void) initDescriptions;

- (AudioPreset *) create:(AUGraph) graph;
- (AudioPreset *) connect:(AUNode)input with:(AUNode)output;
- (AudioPreset *) disconnect:(AUNode)output;

- (id) distortion: (AudioUnitParameterID)type to:(AudioUnitParameterValue) value;
- (id) reverb: (AudioUnitParameterID)type to:(AudioUnitParameterValue) value;
- (id) compression: (AudioUnitParameterID)type to:(AudioUnitParameterValue) value;
- (id) bandpass: (AudioUnitParameterID)type to:(AudioUnitParameterValue) value;

@end
