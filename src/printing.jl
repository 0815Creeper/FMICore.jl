#
# Copyright (c) 2021 Tobias Thummerer, Lars Mikelsons
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

"""
Log levels for non-standard printing of infos, warnings and errors.
"""
const FMULogLevel = Cuint
const FMULogLevelNone  = Cuint(0)
const FMULogLevelInfo  = Cuint(1)
const FMULogLevelWarn  = Cuint(2)
const FMULogLevelError = Cuint(3)
export FMULogLevel, FMULogLevelNone, FMULogLevelInfo, FMULogLevelWarn, FMULogLevelError 

"""
Prints a message with level `info` if the log level allows it.
"""
function printInfo(fmu::FMU, message)
    if fmu.logLevel <= FMULogLevelInfo
        @info message
    end
end
export printInfo

"""
Prints a message with level `warn` if the log level allows it.
"""
function printWarning(fmu::FMU, message)
    if fmu.logLevel <= FMULogLevelWarn
        @warn message
    end
end
export printWarning

"""
Prints a message with level `error` if the log level allows it.
"""
function printError(fmu::FMU, message)
    if fmu.logLevel <= FMULogLevelError
        @error message
    end
end
export printError

