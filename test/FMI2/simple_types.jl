#
# Copyright (c) 2021 Tobias Thummerer, Lars Mikelsons, Josef Kircher
# Licensed under the MIT license. See LICENSE file in the project root for details.
#

attr_dict = Dict(
    :Real => FMIC.fmi2SimpleTypeAttributesReal,
    :Integer => FMIC.fmi2SimpleTypeAttributesInteger,
    :Boolean => FMIC.fmi2SimpleTypeAttributesBoolean,
    :String => FMIC.fmi2SimpleTypeAttributesString,
    :Enumeration => FMIC.fmi2SimpleTypeAttributesEnumeration,
)

for (attr_symb, attr_type) in attr_dict
    attr_struct = attr_type()

    # check if all attribute fields initialize to `nothing`
    for fn in fieldnames(attr_type)
        @test isnothing(getfield(attr_struct, fn))
    end

    type_obj = fmi2SimpleType("testType", attr_struct)
    
    # check initial values and defaults
    @test type_obj.name == "testType"
    @test isnothing(type_obj.description)

    type_obj = fmi2SimpleType("testType", attr_struct, "Some Description")
     # check initial values and defaults
    @test type_obj.name == "testType"
    @test type_obj.description == "Some Description"

    # check special getters
    @test getfield(type_obj, :type) == attr_struct
    @test hasproperty(type_obj, attr_symb)
    @test getproperty(type_obj, attr_symb) == attr_struct

    # check special setters
    for (other_symb, other_type) in attr_dict
        other_struct = other_type()
        if attr_symb == other_symb
            setproperty!(type_obj, attr_symb, other_struct)
            @test getproperty(type_obj, attr_symb) === other_struct
        else
            @test !hasproperty(type_obj, other_symb)
            # property `other_symb` should not be present => throw error
            @test_throws AssertionError getproperty(type_obj, other_symb)
            # do not allow setting wrong property type (and changing it thereby!)
            @test_throws AssertionError setproperty!(type_obj, attr_symb, other_struct)
        end
    end

end