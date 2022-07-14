-- Created by: SiriusLatte
-- Version: 1.0.1

-- Documentation

-- Variables
local Instances = {}
Instances.events = setmetatable({}, {
	__index = function(_, key: string): string
		return key
	end,
})
Instances.ref = "REFERENCE_POINTER"

local Stateful = {}
Stateful.__index = Stateful

local Reference = {}
Reference.__index = Reference

-- Types
type Instances = typeof(Instances.create(...))
type InstanceType = Instances | Instance
type Reference = typeof(Instances.createReference())
type StatefulComponent = typeof(Instances.createStateful({}))

type StatefulExtensions = {
	PreRender: () -> nil,
}

-- Functions
function Instances.create(
	name: string,
	properties: { [string]: any },
	children: { [string]: InstanceType },
	instance: Instance
): Instances
	assert(
		type(name) == "string",
		"[Instances]: The first argument should be a string and a valid Instance class name."
	)

	properties = properties or {}
	instance = instance or Instance.new(name)

	-- Events connection
	if properties.events then
		for event, callback in pairs(properties.events[1]) do
			instance[event]:Connect(callback)
		end

		properties.events = nil
	end

	if properties.extensions then
		Instances._extensionsListener(instance, properties.extensions[1])
		properties.extensions = nil
	end

	-- Attributes
	if properties.attributes then
		for nameOf, value in pairs(properties.attributes[1]) do
			instance:SetAttribute(nameOf, value)
		end

		properties.attributes = nil
	end

	if properties[Instances.Ref] then
		properties[Instances.Ref]._instance = instance

		properties[Instances.Ref] = nil
	end

	-- Properties
	for key, value in pairs(properties) do
		if key == Instances.Ref then
			value._instance = instance

			continue
		else
			local typeOf = type(value)
			if typeOf == "function" then
				local returnValue = value()
				instance[key] = returnValue
			else
				instance[key] = value
			end
		end
	end

	-- Children creation
	if children then
		for nameChildren, child in pairs(children) do
			child.Name = nameChildren
			child.Parent = instance
		end
	end

	return instance
end

function Instances.parentChildren(parent: InstanceType, children: { [string]: InstanceType })
	for name, child in pairs(children) do
		child.Name = name
		child.Parent = parent
	end

	return children
end

function Instances.clone(instance: InstanceType, properties: { [string]: any }, children: { [string]: InstanceType })
	return Instances.Create("", properties, children, instance:Clone())
end

function Instances.createStateful(configuration: { [string]: any }): StatefulComponent
	return setmetatable({
		identifier = configuration.Name,
		state = {},
		currentRendered = false,
		extensions = configuration.extensions,
	}, Stateful)
end

function Instances.ConstructTree(statefulComponent: StatefulComponent, parent: InstanceType): nil
	if not statefulComponent.currentRendered then
		warn("[Instances]: Nothing has been set to be rendered!")
	else
		statefulComponent:_construct(parent)
	end
end

function Instances.safeLoad(
	instance: InstanceType,
	ChildrenDescription: { [string]: InstanceType }
): InstanceType | { InstanceType }
	local Child
	local Children = {} -- if multiple end-points

	for ChildName, ChildValue in pairs(ChildrenDescription) do
		Child = instance:FindFirstChild(ChildName)
		if not Child then
			repeat
				Child = instance:FindFirstChild(ChildName)
				task.wait()
			until Child
		end

		if typeof(ChildValue) == "table" then
			instance.SafeLoad(Child, ChildValue)
		else
			table.insert(Children, Child)
		end
	end

	if #Children > 1 then
		-- More than one child to return
		return table.unpack(Children)
	else
		return Child -- simple Child
	end
end

function Instances._extensionsListener(instance: InstanceType, extensions)
	instance.AncestryChanged:Connect(function(_, Parent)
		if not Parent then
			extensions.Destroyed()
		else
			extensions.Created()
		end
	end)
end

function Instances.createReference(instance: InstanceType): Reference
	return setmetatable({
		_instance = instance,
	}, Reference)
end

function Reference:getInstance(): InstanceType
	return self._instance
end

function Stateful:setState(passed: any): nil
    local typeOf = type(passed)
    local currentState = self.State

	if typeOf == "function" then
		self.State = passed(currentState)
	else
		self.State = passed
	end

	self:_render()
end

function Stateful:set(name: string, passed: any): nil
    local typeOf = type(passed)
    local currentState = self.State[name]

	if typeOf == "function" then
		self.State[name] = passed(currentState)
	else
		self.State[name] = passed
	end

	self:_render()
end

function Stateful:_construct(parent: InstanceType): nil
	local function startSafe(statefulComponent: StatefulComponent): nil
		if statefulComponent.Start then
			self:_invokeExtension("Starting")

			xpcall(function()
				statefulComponent:Start()
			end, error)

			self:_invokeExtension("Started")
		end
	end

	local function renderSafe(statefulComponent: StatefulComponent): nil
		if statefulComponent.Render then
			self:_invokeExtension("PreRender")

			xpcall(function()
				local tree = statefulComponent:Render()
				tree.Parent = parent

				self.CurrentRendered = tree
			end, error)

			self:_invokeExtension("PostRender")
		end
	end

	task.spawn(function()
		startSafe(self)
		renderSafe(self)
	end)
end

function Stateful:_render()
	if self.CurrentRendered then
		local localParent = self.CurrentRendered.Parent
		self.CurrentRendered:Destroy()

		local instance = self:OnRender()
		instance.Parent = localParent

		self.CurrentRendered = instance
	end
end

function Stateful:_invokeExtension(extensionName: string): nil
	local extensions = self.Extensions
	local indexOf = extensions[extensionName]

	if extensions and indexOf then
		indexOf()
	end
end

-- Returning value
return Instances
